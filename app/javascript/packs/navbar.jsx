import React, { useState, useEffect, useRef } from 'react';
import ReactDOM from 'react-dom/client';

window.addEventListener("DOMContentLoaded", function () {

    function Navbar() {
        const [isMenuOpen, setIsMenuOpen] = useState(false);
        const [userLoggedIn, setUserLoggedIn] = useState(false);
        const navbarRef = useRef(null);

        useEffect(() => {
            fetch('/check_login_status')
                .then((response) => response.json())
                .then((data) => {
                    setUserLoggedIn(data.loggedIn);
                })
                .catch((error) => {
                    console.log('ログインステータスの確認中にエラーが発生しました', error);
                });
        }, []);

        const handleDocumentClick = (event) => {
            if (navbarRef.current && navbarRef.current.contains(event.target)) {
                return;
            }
            
            if (isMenuOpen) {
                setIsMenuOpen(false);
            }
        };

        useEffect(() => {
            document.addEventListener('click', handleDocumentClick);

            return () => {
                document.removeEventListener('click', handleDocumentClick);
            };
        }, [isMenuOpen]);
        
        const toggleMenu = () => {
          setIsMenuOpen(!isMenuOpen);
        };
        
        return (
          <nav id="navbar" ref={navbarRef}>
            <div onClick={toggleMenu} id="navbar-toggle" className={isMenuOpen ? 'open' : ''}>
                  <span className="bar"></span>
                  <span className="bar"></span>
                  <span className="bar"></span>
            </div>
            <div onClick={toggleMenu} className={`hidden-menu ${isMenuOpen ? 'open' : ''}`}>
                <span className="bar"></span>
                <span className="bar"></span>
                <span className="bar"></span>
                {!userLoggedIn && (
                    <ul>
                        <li><a href="/sign_up">新規会員登録</a></li>
                        <li><a href="/users/sign_in">ログイン</a></li>
                    </ul>
                )}
                {userLoggedIn && (
                    <ul>
                        <li><a href="/mypage/edit">会員情報変更</a></li>
                    </ul>
                )}
            </div>
          </nav>
        );
      }
      
      const root = ReactDOM.createRoot(document.getElementsByClassName('bulsup_header_right')[0]);
      root.render(<Navbar />);
});


